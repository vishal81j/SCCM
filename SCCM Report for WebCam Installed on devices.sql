select distinct vrs.Netbios_Name0 as 'Device Name', vrs.User_Name0 as 'User Name',
CASE
WHEN Vse.ChassisTypes0 in ('1') THEN 'Virtual'
WHEN Vse.ChassisTypes0 in ('8','9','10','12','14','11','17','31','32') THEN 'Laptop'
WHEN Vse.ChassisTypes0 in ('2','3','4','5','6','7','13','15','16','35') THEN 'Desktop'
WHEN Vse.ChassisTypes0 in ('23') THEN 'RackMount'
when Vse.ChassisTypes0 is Null Then 'NA'
Else 'Others' END as 'ChassisType',
Vcs.Manufacturer0 as 'Manufacturer',
CASE WHEN CAST(Vcs.Manufacturer0 as NVarchar(255)) LIKE '%LENOVO%'
THEN CAST(Vcsp.Version0 as NVarchar(255)) ELSE CAST(Vcs.Model0 as NVarchar(255)) END AS 'Model',
pnp.Name0,pnp.DeviceID0
from v_GS_PNP_DEVICE_DRIVER pnp 
Left Join v_R_System vrs on pnp.ResourceID = vrs.ResourceID
LEFT JOIN V_GS_COMPUTER_SYSTEM as Vcs ON VCS.ResourceID = Vrs.ResourceID
LEFT JOIN V_GS_COMPUTER_SYSTEM_PRODUCT Vcsp ON Vcsp.ResourceID = Vrs.ResourceID
LEFT JOIN V_GS_SYSTEM_ENCLOSURE as Vse ON Vse.ResourceID = Vrs.ResourceID
where pnp.Name0 like '%Webcam%'
order by vrs.Netbios_Name0