{ config, pkgs, ... }:

{
  services.borgbackup.jobs."borgbase" = {
    paths = [
      "/home/meeri"
    ];
    exclude = [
      # very large paths
      "/home/meeri/Torrents"
      "/home/meeri/videos-n-stuff-to-check"
      "/home/meeri/.cache"
      "/home/meeri/.mozilla"
      "/home/meeri/temp"
    ];
    repo = "eob45owc@eob45owc.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borgbackup/passphrase";
    };
    environment.BORG_RSH = "ssh -i /root/borgbackup/ssh_key";
    compression = "auto,lzma";
    startAt = "daily";
  };
}
