module CC2520SecurityP{
  provides interface CC2520Security;
}
implementation{

  norace uint8_t MODE, K_LENGTH;
  norace uint32_t FRAMECOUNTER = 0;
  uint8_t PKEY[16];

  async command uint8_t CC2520Security.getSecurityMode(){
    return MODE;
  }

  command void CC2520Security.setSecurityMode(uint8_t mode){
    atomic MODE = mode;
  }

  command void CC2520Security.setKey(uint8_t* pKey, uint8_t length){
    memcpy(PKEY, pKey, length);
  }

  async command uint8_t* CC2520Security.getKey(){
    return PKEY;
  }

  async command uint32_t CC2520Security.getFrameCounter(){
    return FRAMECOUNTER++;
  }
}