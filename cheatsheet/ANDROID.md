# Android Installation Tips

This tips and tricks for Android Phone

# Regain Apps Control via Work Profile

This trick will enable you to "disable" any apps, even they're protected with system privilege.
There is some apps which use Android's Work Profile to "disable" those apps:

## `Island`

Island the secret island inside your android device, please visit the [Website](https://island.oasisfeng.com/) or [Play Store](https://play.google.com/store/apps/details?id=com.oasisfeng.island&hl=en).

## `Insular`

`Insular` is a fork from `Island` without any "Spying" lib, it has same code base (even some the link and apps name still using `Island`).
Please visit [Website](https://secure-system.gitlab.io/Insular/) or [F-Droid](https://f-droid.org/packages/com.oasisfeng.island.fdroid/) for more information.

Known Issue(s):
- `myBCA` is broken after `Insular` gain Profile Owner Privilege

## `Hail` Apps

Apps that can utilize Device Owner privilege to "disable" protected apps,
unfortunately it will refure to use Device Owner if we grant Profile Owner privilege.
This app require exactly Device Owner privilege.

## `Ice Box`

Another apps capable to use Device Owner or Profile Owner privilege to "disable" protected apps,
this app is similar with `Hail`.

Known Issue(s):
- `Permata ME` is broken, uninstalling it fix the issue. It seems `Permata ME` have some blacklisted apps.

## `Dhizuku`

An apps that grant other apps of Device Owner or Profile Owner privilege, please visit [Github](https://github.com/iamr0s/Dhizuku) page for details.

