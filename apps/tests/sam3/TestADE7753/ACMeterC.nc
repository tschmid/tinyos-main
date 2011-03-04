/*
 * Copyright (c) 2011 The Regents of the University  of California.
 * All rights reserved."
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/**
 * AC Mote and Energy Meter using ADE7753
 * @ Fred Jiang <fxjiang@eecs.berkeley.edu>
 */

configuration ACMeterC {
  provides { 
    interface SplitControl;
    interface ReadStream<uint32_t> as ReadEnergy;
    interface GetSet<acmeter_state_t> as RelayConfig;
    interface GetSet<uint8_t> as GainConfig;
    interface Get<uint32_t> as GetPeriod32;
  }
}

implementation {
  components MainC;
  components ACMeterM, ADE7753P, LedsC;
  components new Alarm32khz32C() as SampleAlarmC;
  components new Msp430Spi1C() as SpiC;
  components HplMsp430GeneralIOC;

  SplitControl = ACMeterM;
  ReadEnergy = ACMeterM;
  RelayConfig = ACMeterM;
  GainConfig = ACMeterM;
  GetPeriod32 = ACMeterM;

  MainC.SoftwareInit -> ADE7753P.Init;	
  ACMeterM.Leds -> LedsC;
  ACMeterM.ADE7753 -> ADE7753P;
  ACMeterM.MeterControl -> ADE7753P;
  ACMeterM.SampleAlarm -> SampleAlarmC;
  ACMeterM.onoff -> HplMsp430GeneralIOC.Port21;
  ADE7753P.SpiPacket -> SpiC;
  ADE7753P.SPIFRM -> HplMsp430GeneralIOC.Port54;
  ADE7753P.Leds -> LedsC;
  ADE7753P.Resource -> SpiC;
}
