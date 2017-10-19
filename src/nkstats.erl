%% -------------------------------------------------------------------
%%
%% Copyright (c) 2017 Carlos Gonzalez Florido.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------
-module(nkstats).
-export([parse_exporter/3, 
         exporter_service_spec/2,
         register_metric/4,
         record_value/4]).
-include("nkstats.hrl").

parse_exporter(SrvId, Config, Opts) ->
    SrvId:nkstats_parse_exporter(Config, Opts).

exporter_service_spec(SrvId, Exporter) ->
    SrvId:nkstats_exporter_service_spec(Exporter).

register_metric(SrvId, Type, Name, Desc) ->
    lists:foreach(fun(Exporter) ->
                    SrvId:register_metric(Exporter, Type, Name, Desc)  
                  end, service_stats_exporters(SrvId)).


record_value(SrvId, Type, Name, Value) ->
    lists:foreach(fun(Exporter) ->
                    SrvId:record_value(Exporter, Type, Name, Value)  
                  end, service_stats_exporters(SrvId)).

service_stats_exporters(SrvId) ->
    Config = SrvId:config(),
    maps:get(stats_exporters, Config, []).
