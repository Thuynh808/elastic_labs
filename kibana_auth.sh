#!/bin/bash

echo -n "elastic:{{ lookup('file', './password_result') }}" | base64 > kibana_auth

