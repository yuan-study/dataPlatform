--建表语句请不要重复执行
create table fwa_statistics_res
(
  info varchar2(100),
  tabid varchar2(30),
  dcount integer
);

declare
  count1 integer;
  v_tab  varchar2(50);
  v_info varchar2(50);
  v_sql  varchar2(300);
  v_type varchar2(1);
  --v_sq2  varchar2(300);
begin
  --清理结果表
  delete from fwa_statistics_res;
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('单据数量', 'fwa_bill_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('参保人数量', 'fwa_patient_basic_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('医疗机构数量', 'fwa_medical_org_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('医护人员数量', 'fwa_doctor_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('就诊信息数量', 'fwa_visit_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('处方单据明细数量', 'fwa_bill_info_detail', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('结算信息数量-未统计', '', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('病案信息数量', 'fwa_medl_page', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('药品信息数量', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('诊疗项目数量', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('服务设施数量', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('疾病数量', 'fwa_diagnose_code_desc', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('诊断数量', 'fwa_disease_diagnose', '');
  for i in (select INFO, TABID
              from fwa_statistics_res
             where TABID is not null) loop
    v_info := i.info;
    v_tab  := i.TABID;
    if v_info = '药品信息数量' then
     v_type:='1';
    end if;
    if v_info = '诊疗项目数量' then
     v_type:='2';
    end if;
    if v_info = '服务设施数量' then
     v_type:='3';
    end if;
    if v_tab <> 'fwa_three_directory' then
      v_sql  := 'select count(1)  from ' || v_tab;
    else
      v_sql  := 'select count(1)  from ' || v_tab || ' where project_type = ' || v_type;
    end if;
    EXECUTE IMMEDIATE v_sql
      into count1;
    update fwa_statistics_res set DCOUNT = count1
     where INFO = v_info and TABID = v_tab;
    commit;
  end loop;
end;
/
