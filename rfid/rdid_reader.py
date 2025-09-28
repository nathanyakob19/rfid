import subprocess
import time

def nfc_raw():
    lines = subprocess.check_output("/usr/bin/nfc-poll", stderr=open('/dev/null','w'))
    return lines

def read_nfc():
    lines = nfc_raw()
    return lines

try:
    while True:
        myLines = read_nfc()
        buffer = []
        for line in myLines.splitlines():
            line_content = line.split()
            if(not line_content[0] == 'UID'):
                pass
            else:
                buffer.append(line_content)
        str = buffer[0]
        id_str = str[2]+str[3]+str[4]+str[5]
        print(id_str)

except KeyboardInterrupt:
    pass
