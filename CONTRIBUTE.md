### Note about packaging

##### Build and install locally

```
user in void-linux in void-packages on x2goclient
➜ ./xbps-src bootstrap-update
[...]

user in void-linux in void-packages on x2goclient
➜ ./xbps-src pkg x2goclient
[...]

user in void-linux in void-packages on x2goclient
➜ sudo xbps-install --repository hostdir/binpkgs/x2goclient/ x2goclient
[...]
```

##### Fixup a commit and rebase
```
void-packages/srcpkgs/x2goclient on x2goclient !
➜ git --no-pager diff
diff --git a/srcpkgs/x2goclient/template b/srcpkgs/x2goclient/template
index e794a0d001..aa08b3aebf 100644
--- a/srcpkgs/x2goclient/template
+++ b/srcpkgs/x2goclient/template
@@ -6,7 +6,7 @@ build_style=gnu-makefile
 make_build_target="build_client build_man"
 make_install_target="install_client install_man"
 hostmakedepends="pkg-config qt-devel-tools"
-makedepends="qt-devel libldap-devel libssh-devel libXpm-devel cups-devel"
+makedepends="qt5-devel libldap-devel libssh-devel libXpm-devel cups-devel"
 depends="nx-libs"
 short_desc="Graphical Qt5 client for X2Go"
 maintainer="eoli3n <jkirsz@gmail.com>"

void-packages/srcpkgs/x2goclient on x2goclient !
➜ git log --oneline | head -n4
8c941871ef New package: x2goserver-4.1.0.3
24f738663d New package: x2goclient-4.1.2.2
ebe0d964f5 New package: nx-libs-3.5.99.24
2bfbb3ffff linux5.10: update to 5.10.3.

void-packages/srcpkgs/x2goclient on x2goclient !
➜ git add .

void-packages/srcpkgs/x2goclient on x2goclient +
➜ git commit --fixup 24f738663d
[x2goclient 01eb1efe97] fixup! New package: x2goclient-4.1.2.2
 1 file changed, 1 insertion(+), 1 deletion(-)

void-packages/srcpkgs/x2goclient on x2goclient ⇡1
➜ git rebase -i --autosquash 2bfbb3ffff
Rebasage et mise à jour de refs/heads/x2goclient avec succès.

void-packages/srcpkgs/x2goclient on x2goclient ⇕⇡2⇣2  3s
➜ git push -f origin x2goclient
```

##### Rebase upstream
```
void-packages/srcpkgs/x2goclient on x2goclient
➜ git remote add upstream git://github.com/void-linux/void-packages.git

void-packages/srcpkgs/x2goclient on x2goclient
➜ git pull upstream master --rebase --autostash
remote: Enumerating objects: 10979, done.
remote: Counting objects: 100% (10979/10979), done.
remote: Compressing objects: 100% (3111/3111), done.
remote: Total 8760 (delta 4949), reused 8155 (delta 4699), pack-reused 0
Réception d'objets: 100% (8760/8760), 1.60 Mio | 549.00 Kio/s, fait.
Résolution des deltas: 100% (4949/4949), complété avec 976 objets locaux.
Depuis git://github.com/void-linux/void-packages
 * branch                  master     -> FETCH_HEAD
 * [nouvelle branche]      master     -> upstream/master
Rebasage et mise à jour de refs/heads/x2goclient avec succès.

void-packages/srcpkgs on x2goclient ⇕⇡1655⇣3  via 🌙 v5.4.2
➜ git push --force
Énumération des objets: 10999, fait.
Décompte des objets: 100% (10999/10999), fait.
Compression par delta en utilisant jusqu'à 8 fils d'exécution
Compression des objets: 100% (2880/2880), fait.
Écriture des objets: 100% (8780/8780), 1.63 Mio | 3.18 Mio/s, fait.
Total 8780 (delta 4957), réutilisés 8764 (delta 4948), réutilisés du pack 0
remote: Resolving deltas: 100% (4957/4957), completed with 976 local objects.
To github.com:eoli3n/void-packages.git
 + dfb75ec1b4...070372a4c2 x2goclient -> x2goclient (forced update)
```
