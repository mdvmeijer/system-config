#!/usr/bin/env bash

vpnStatus=$(mullvad status)

[[ ${vpnStatus} == "Disconnected" ]] && mullvad connect
[[ ${vpnStatus} == "Disconnected" ]] || mullvad disconnect
