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
-export([parse_exporter/3]).
-export_type([exporter_id/0, exporter/0]).
-include("nkstats.hrl").

-type exporter_id() :: term().
-type exporter() :: #{ config => map() }.

-spec parse_exporter(nkservice:id(), map(), nklib_syntax:parse_opts()) ->
    {ok, exporter(), [binary()]} | {error, term()}.
parse_exporter(SrvId, Map, ParseOpts) ->
    SrvId:nkstats_parse_exporter(Map, ParseOpts).
