interface CC2520Security{
  async command uint8_t getSecurityMode();
  command void setSecurityMode(uint8_t mode);
  command void setKey(uint8_t* pKey, uint8_t length);
  async command uint8_t* getKey();
  async command uint32_t getFrameCounter();
}
