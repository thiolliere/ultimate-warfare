#!/bin/bash

cd "$(dirname "$0")"
name="$(basename "$(pwd)")"
zip -r ../"$name".love *
