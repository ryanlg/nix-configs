{ config, ... }:
{
  # Save upon losing focus
  autoCmd = [
    {
      event = [
        "BufLeave"
        "FocusLost"
      ];
      command = "silent! wa";
    }
  ];
}
