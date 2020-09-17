bpb_s STRUCT
    ; Dos 4.0 EBPB 1.44MB floppy
    OEMname            db    "mkfs.fat"  ; mkfs.fat is what OEMname mkdosfs uses
    bytesPerSector     dw    512
    sectPerCluster     db    1
    reservedSectors    dw    1
    numFAT             db    2
    numRootDirEntries  dw    224
    numSectors         dw    2880
    mediaType          db    0f0h
    numFATsectors      dw    9
    sectorsPerTrack    dw    18
    numHeads           dw    2
    numHiddenSectors   dd    0
    numSectorsHuge     dd    0
    driveNum           db    0
    reserved           db    0
    signature          db    29h
    volumeID           dd    2d7e5a1ah
    volumeLabel        db    "NO NAME    "
    fileSysType        db    "FAT12   "
bpb_s ENDS
