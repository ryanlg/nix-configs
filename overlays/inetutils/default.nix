final: prev: {
  inetutils =
    if prev.stdenv.hostPlatform.isDarwin then
      prev.inetutils.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./inetutils-format-security.patch ];
      })
    else
      prev.inetutils;
}
