<!DOCTYPE mycat:schema SYSTEM "schema.dtd">
<mycat:schema xmlns:mycat="http://io.mycat/">

    <schema name="pth" checkSQLschema="false" sqlMaxLimit="100">
        <table name="teacher" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_blob_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_calendars" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_cron_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_fired_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_job_details" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_locks" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_paused_trigger_grps" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_scheduler_state" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_simple_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_simprop_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="qrtz_triggers" type="global" dataNode="dn1,dn2"></table>
        <table name="sys_config" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_action" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_checkin" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_city" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_dept" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_face_model" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_holidays" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_meeting" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_module" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_permission" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_role" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_user" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_workday" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_customer" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_employee" type="global" dataNode="dn1,dn2"></table>
        <table name="tb_appointment" type="global" dataNode="dn1,dn2"></table>
    </schema>
    <schema name="data_permissions" checkSQLschema="false" sqlMaxLimit="100">
        <table name="sys_acl" type="global" dataNode="dn3"></table>
        <table name="sys_acl_module" type="global" dataNode="dn3"></table>
        <table name="sys_dept" type="global" dataNode="dn3"></table>
        <table name="sys_log" type="global" dataNode="dn3"></table>
        <table name="sys_role" type="global" dataNode="dn3"></table>
        <table name="sys_role_acl" type="global" dataNode="dn3"></table>
        <table name="sys_role_user" type="global" dataNode="dn3"></table>
        <table name="sys_user" type="global" dataNode="dn3"></table>
    </schema>
    <dataNode name="dn1" dataHost="rep1" database="pth"/>
    <dataNode name="dn2" dataHost="pxc1" database="pth"/>
    <dataNode name="dn3" dataHost="rep1" database="data_permissions"/>



    <dataHost name="rep1" maxCon="1000" minCon="10" balance="3"
              writeType="0" dbType="mysql" dbDriver="native" switchType="1" slaveThreshold="100">
        <heartbeat>select user()</heartbeat>
        <writeHost host="p1w1" url="172.17.0.7:9001" user="root" password="Wwangyuefeng2$">
            <readHost host="r1r1" url="172.17.0.8:9001" user="root" password="Wwangyuefeng2$"/>
            <readHost host="r1r2" url="172.17.0.13:9001" user="root" password="Wwangyuefeng2$"/>
        </writeHost>
    </dataHost>

    <dataHost name="pxc1" maxCon="1000" minCon="10" balance="0"
              writeType="0" dbType="mysql" dbDriver="native" switchType="1" slaveThreshold="100">
        <heartbeat>select user()</heartbeat>
        <writeHost host="p1w1" url="172.17.0.7:3306" user="root" password="root"/>
        <writeHost host="p1w2" url="172.17.0.8:3306" user="root" password="root"/>
        <writeHost host="p1w3" url="172.17.0.13:3306" user="root" password="root"/>
    </dataHost>

</mycat:schema>