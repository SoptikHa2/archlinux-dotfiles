#!/bin/zsh

set -euo pipefail

# Let user choose profile
(
set -euo pipefail
cd ~/.mozilla/firefox
echo "Choose target firefox profile to alter:"
ls | grep '.default' | cat -n -
read -r ff_profile_number
chosen_profile=$(ls | grep '.default' | head -$ff_profile_number | tail -1)
echo "Chosen profile: $chosen_profile. Is this correct? [y/N]"
read -r ff_profile_number_confirm
if [[ $ff_profile_number_confirm != "y" ]]; then
    return 1
fi
echo "Backing up..."
tar zvcfp "$chosen_profile-backup.tar.gz" "$chosen_profile" >/dev/null
cd $chosen_profile 

echo "Updating about:config..."
echo 'user_pref("devtools.debugger.remote-enabled, true);' | tee -a user.js
echo 'user_pref("devtools.theme, dark);' | tee -a user.js
echo 'user_pref("media.navigator.enabled, false);' | tee -a user.js
echo 'user_pref("media.peerconnection.enabled, false);' | tee -a user.js
echo 'user_pref("network.trr.mode, 2);' | tee -a user.js
echo 'user_pref("privacy.resistFingerprinting, true);' | tee -a user.js
echo 'user_pref("privacy.spoof_english, 2);' | tee -a user.js
echo 'user_pref("privacy.trackingprotection.enabled, true);' | tee -a user.js
echo 'user_pref("privacy.userContext.enabled, true);' | tee -a user.js
echo 'user_pref("devtools.chrome.enabled, true);' | tee -a user.js
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets, true);' | tee -a user.js
echo 'user_pref("full-screen-api.warning.timeout, 0);' | tee -a user.js
echo 'user_pref("layers.acceleration.force-enabled, true);' | tee -a user.js
echo 'user_pref("gfx.webrender.all, true);' | tee -a user.js
echo 'user_pref("browser.sessionstore.resume_from_crash, false);' | tee -a user.js
echo 'user_pref("browser.in-content.dark-mode, true);' | tee -a user.js
echo 'user_pref("ui.systemUsesDarkTheme, 1);' | tee -a user.js
echo 'user_pref("browser.cache.disk.enable, false);' | tee -a user.js
echo 'user_pref("browser.cache.memory.enable, true);' | tee -a user.js
echo 'user_pref("browser.cache.memory.capacity, -1);' | tee -a user.js
echo 'WARNING: User prefs seem to not work. Please enable the previous preferences manually with about:config. You can find full list here: https://github.com/SoptikHa2/archlinux-dotfiles#firefox-aboutconfig'

# Setup userchrome
mkdir chrome -p
ln -sf ~/archlinux-dotfiles/firefox/userC* chrome/

# Move entire firefox profile to ram
echo "Moving FF profile to RAM. Make sure to close all firefox instances."
echo "Continue?"
read -r
psd
sed -i 's/#BROWSERS=()/BROWSERS=(firefox)/' ~/.config/psd/psd.conf
systemctl --user enable psd.service
systemctl --user start psd.service
) || ./setup-firefox.sh
