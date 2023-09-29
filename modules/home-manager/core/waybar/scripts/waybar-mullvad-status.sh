#!/usr/bin/env bash

vpnStatus=$(mullvad status)

[[ $vpnStatus == "Disconnected" ]] && echo "{\"text\": \"\", \"tooltip\": \"${vpnStatus}\", \"class\": \"disconnected\"}"
[[ $vpnStatus == "Disconnected" ]] || echo "{\"text\": \"\", \"tooltip\": \"${vpnStatus}\", \"class\": \"connected\" }"
