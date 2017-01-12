#!/usr/bin/env python3

import json
import os
import os.path
import sys

d = 'schemas'

setupDict = {
    'schemas': [
            schema for schema in os.listdir(d)
            if os.path.isdir(os.path.join(d, schema))
            and not schema.startswith('.')
        ],
    'schema_dirs': [d]
}

json.dump(setupDict, sys.stdout)
