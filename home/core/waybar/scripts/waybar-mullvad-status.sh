#!/usr/bin/env bash

vpnStatus=$(mullvad status)

[[ $vpnStatus == "Disconnected" ]] && echo "{\"text\": \"\", \"tooltip\": \"${vpnStatus}\", \"class\": \"disconnected\"}" && exit 0
[[ $vpnStatus =~ ^Connected.* ]] && echo "{\"text\": \"\", \"tooltip\": \"${vpnStatus}\", \"class\": \"connected\" }" && exit 0
echo "{\"text\": \"❗\", \"tooltip\": \"${vpnStatus}\", \"class\": \"offline\" }"
