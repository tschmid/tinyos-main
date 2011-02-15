 /*
 * Copyright (c) 2010, Vanderbilt University
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 *
 * IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
 * UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * Author: Janos Sallai
 * Author: Thomas Schmid (adapted to CC2520)
 * Author: JeongGil Ko (Security Header Added)
 */

#ifndef __CC2520RADIO_H__
#define __CC2520RADIO_H__

#include <RadioConfig.h>
#include <TinyosNetworkLayer.h>
#include <Ieee154PacketLayer.h>
#include <ActiveMessageLayer.h>
#include <MetadataFlagsLayer.h>
#include <CC2520DriverLayer.h>
#include <TimeStampingLayer.h>
#include <LowPowerListeningLayer.h>
#include <PacketLinkLayer.h>

/**
 * CC2520 Security Header
 */
typedef nx_struct security_header_t {
  nx_uint8_t secLevel:3;
  nx_uint8_t keyMode:2;
  nx_uint8_t reserved:3;
  nx_uint32_t frameCounter;
  nx_uint8_t keyID[1]; // One byte for now
} security_header_t;


typedef nx_struct cc2520packet_header_t
{
  cc2520_header_t cc2520;
  ieee154_header_t ieee154;

#ifdef CC2520_HW_SECURITY
  security_header_t secHdr;
#endif

#ifndef TFRAMES_ENABLED
  network_header_t network;
#endif
#ifndef IEEE154FRAMES_ENABLED
  activemessage_header_t am;
#endif
} cc2520packet_header_t;

typedef nx_struct cc2520packet_footer_t
{
  // the time stamp is not recorded here, time stamped messaged cannot have max length
} cc2520packet_footer_t;

typedef struct cc2520packet_metadata_t
{
#ifdef LOW_POWER_LISTENING
  lpl_metadata_t lpl;
#endif
#ifdef PACKET_LINK
  link_metadata_t link;
#endif
  timestamp_metadata_t timestamp;
  flags_metadata_t flags;
  cc2520_metadata_t cc2520;
} cc2520packet_metadata_t;

enum cc2520_security_enums{
  NO_SEC = 0,
  CBC_MAC_4 = 1,
  CBC_MAC_8 = 2,
  CBC_MAC_16 = 3,
  CTR_MODE = 4,
  CCM_4 = 5,
  CCM_8 = 6,
  CCM_16 = 7
};

#endif//__CC2520RADIO_H__
