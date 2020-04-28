#!/usr/bin/env python
import urllib2

# -*- coding: utf-8 -*-

"""
Copyright (C) 2015 - 2017 Martin Kauss (yo@bishoph.org)
Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at
 http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations
under the License.
"""

# plugin for direct control of zigbee devices over mqtt

devices = [
    "corner",
    "desktop",
    "light",
    "lamp"
]

orders = [
    "on",
    "off"
]

devicesIds = {
    "corner": ["0x7cb03eaa0a013f10"],
    "desktop": ["0x84182600000d7f89"],
    "lamp": ["0x7cb03eaa00b1a173"],
    "light": ["0x00158d0002eff3f6", "0x00158d0002effa6c"],

}


def run(readable_results, data, rawbuf):
    order = get_order(readable_results)
    device = get_device(readable_results)
    if order != "none" and device != "none":
        ids = devicesIds[device]
        for id in ids:
            urllib2.urlopen("http://localhost:5000/homepi/switch_" + order + "_" + id).read()

def get_device(readable_results):
    for device in devices:
        if device in readable_results:
            return device
    return "none"

def get_order(readable_results):
    for order in orders:
        if order in readable_results:
            return order
    return "none"

#             client.publish('zigbee2mqtt/' + id + '/set/state/', order.upper())
