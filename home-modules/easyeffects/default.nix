{
  imports = [ ./preset.nix ];

  services.easyeffects = {
    enable = true;
    presets = [
      {
        # Antlion Modmic Wireless
        device = "alsa_input.usb-Antlion_Audio_Antlion_Wireless_Microphone-00.mono-fallback";
        file = ./presets/Modmic.json;
        type = "input";
        profile = "analog-input-mic";
      }
      {
        # Sennheiser HD6XX - Harman target
        device = "alsa_output.usb-Topping_D10-00.HiFi__hw_D10_0__sink";
        file = ./presets/HD6XX.json;
        type = "output";
        profile = "[Out] Headphones";
      }
      {
        # Samsung Galaxy Buds 2
        device = "bluez_output.58_A6_39_22_AD_A3.1";
        file = ./presets/GalaxyBuds2.json;
        type = "output";
        profile = "headset-output";
      }
    ];
  };
}
