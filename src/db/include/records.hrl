-module(records).

-record(backup_file, {
                        file_name,
                        file_version = 0,
                        file_last_modified, % used to determine if backup needed
                        file_checksum = ""  % maybe it was modified but no contents changed
                    }).

-record(backed_file, {
                        file_name,
                        file_version,
                        file_path
                    }).

-record(folder, {
                    folder_name
                }).

