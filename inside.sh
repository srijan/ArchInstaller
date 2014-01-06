# Variables
HOST=arch
TIMEZONE="Asia/Kolkata"
PASSWORD="password"

# Configuration

echo "###########################   Configuring Hostname   ###########################"
echo $HOST > /etc/hostname

echo "###########################   Configuring Consolemap   ###########################"
echo "KEYMAP=us" > /etc/vconsole.conf
echo "FONT=" >> /etc/vconsole.conf
echo "FONT_MAP=" >> /etc/vconsole.conf

echo "###########################   Configuring Timezone   ###########################"
echo $TIMEZONE > /etc/timezone
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

echo "###########################   Configuring Locales   ###########################"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_COLLATE=C" >> /etc/locale.conf

echo "###########################   Configuring System Time   ###########################"
hwclock --systohc --utc

echo "###########################   Creating RAMDisk   ###########################"
mkinitcpio -p linux

echo "###########################   Configuring GRUB   ###########################"
grub-install /dev/sda
mkdir -p /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
echo "# fix broken grub.cfg gen\nGRUB_DISABLE_SUBMENU=y" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "###########################   Setting Root Password   ###########################"
echo root:$PASSWORD | chpasswd

echo "###########################   Exiting Chroot   ###########################"
exit
