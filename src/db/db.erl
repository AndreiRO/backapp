-module(db).
-include("include/records.hrl").
-compile(export_all).

init() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(backup_file, [{attributes, record_info(backup_file)}]),
    mnesia:create_table(backed_file, [{attributes, record_info(back_file)}]),
    mnesia:create_table(folder, [{attributes, record_info(folder)}]),
    ok.

insert(Table, Record) ->
    Fun = fun() -> mnesia:write(Record) end,
    case Table of
        backup_file -> mnesia:transaction(Fun), ok;
        backed_file -> mnesia:transaction(Fun), ok;
        folder      -> mnesia:transaction(Fun), ok;
                  _ -> error
    end.
