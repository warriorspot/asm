import sys

#Output ascii values for bytes in input file.  Create
#Basic data statements from them, starting at 'num'

if(len(sys.argv) != 3):
    print("Usage: python todata.py [binary file] [starting line number]")
    sys.exit()

file_name = sys.argv[1]
num = int(sys.argv[2])
x = 0
out = str(num) + ' DATA '
with open(file_name, "rb") as f:
    byte = f.read(1)
    while byte != b'':
        out = out + str(int.from_bytes(byte, byteorder='big'))
        if x < 10:
            out = out + ','
        else:
            x = 0
            num += 1
            print(out)
            out = str(num) + ' DATA '
        x += 1
        byte = f.read(1)

    print(out)
