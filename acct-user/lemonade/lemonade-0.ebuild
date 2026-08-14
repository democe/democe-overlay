# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="system user for Lemonade Server"

ACCT_USER_ID=500
ACCT_USER_GROUPS=( lemonade )
ACCT_USER_HOME=/var/lib/lemonade
ACCT_USER_HOME_PERMS=0750

acct-user_add_deps
