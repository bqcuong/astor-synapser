import json
import os
from typing import List, Any, Dict

from synapser.core.data.api import RepairRequest
from synapser.core.data.results import RepairCommand
from synapser.core.database import Signal
from synapser.handlers.tool import ToolHandler


class JKali(ToolHandler):
    """JKali"""

    class Meta:
        label = 'jkali'
        version = 'xyz'

    def repair(self, signals: dict, repair_request: RepairRequest) -> RepairCommand:
        repair_args = repair_request.args
        src = repair_args.get('src')
        test = repair_args.get('test')
        src_class = repair_args.get('src_class')
        test_class = repair_args.get('test_class')
        classpath = repair_args.get('classpath')
        jvm_version = repair_args.get('jvm_version')
        project_name = repair_args.get('project_name')
        perfect_data = repair_args.get('perfect_data')

        self.repair_cmd.add_arg('-jvmversion', jvm_version)
        self.repair_cmd.add_arg('-location', repair_request.working_dir / project_name)
        self.repair_cmd.add_arg('-srcjavafolder', src)
        self.repair_cmd.add_arg('-srctestfolder', test)
        self.repair_cmd.add_arg('-binjavafolder', src_class)
        self.repair_cmd.add_arg('-bintestfolder', test_class)
        self.repair_cmd.add_arg('-dependencies', classpath)
        self.repair_cmd.add_arg('-perfectdata', repair_request.working_dir / project_name / perfect_data)

        for opt, arg in signals.items():
            self.repair_cmd.add_arg(opt=opt, arg='"' + arg + '"')

        self.repair_cmd.cwd = str(repair_request.working_dir / project_name)
        return self.repair_cmd

    def get_patches(self, working_dir: str, target_files: List[str], **kwargs) -> Dict[str, Any]:
        patches_folder = "output_astor"
        patches = {"patches": []}

        project_name = [child_dir for child_dir in os.listdir(working_dir)
                        if os.path.isdir(os.path.join(working_dir, child_dir))][0]
        path_results = os.path.join(working_dir, project_name, patches_folder)

        if os.path.exists(path_results):
            for root, dirnames, filenames in os.walk(path_results):
                for filename in filenames:
                    if filename == "astor_output.json":
                        with open(os.path.join(root, filename)) as fd:
                            data = json.load(fd)
                            patches["patches"] = data["patches"]
        return patches

    def parse_extra(self, extra_args: List[str], signal: Signal) -> str:
        """
            Parses extra arguments in the signals.
        """
        return ""


def load(nexus):
    nexus.handler.register(JKali)
