import pyudev

def GetUSBDevName():
    result = ""
    try:
        context = pyudev.Context()
        removable = [device for device in context.list_devices(subsystem='block',DEVTYPE='disk') if device.attributes.asstring('removable') == "1"]
        for device in removable:
            partitions = [device.device_node for device in context.list_devices(subsystem='block', DEVTYPE='partition', parent=device)]
            ##print("All removable :  {} ".format(",  ".join(partitions)))
            if len(partitions)  >= 1:
                result = partitions[0]
                return result
            else:
                return "None"
    except Exception as e:
        print("None" )
        return None
    return "None"


res =  GetUSBDevName()
print(res)
