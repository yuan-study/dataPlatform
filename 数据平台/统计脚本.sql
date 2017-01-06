--��������벻Ҫ�ظ�ִ��
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
  --��������
  delete from fwa_statistics_res;
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('��������', 'fwa_bill_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('�α�������', 'fwa_patient_basic_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('ҽ�ƻ�������', 'fwa_medical_org_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('ҽ����Ա����', 'fwa_doctor_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('������Ϣ����', 'fwa_visit_info', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('����������ϸ����', 'fwa_bill_info_detail', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('������Ϣ����-δͳ��', '', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('������Ϣ����', 'fwa_medl_page', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('ҩƷ��Ϣ����', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('������Ŀ����', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('������ʩ����', 'fwa_three_directory', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('��������', 'fwa_diagnose_code_desc', '');
  insert into fwa_statistics_res(INFO, TABID, DCOUNT)values('�������', 'fwa_disease_diagnose', '');
  for i in (select INFO, TABID
              from fwa_statistics_res
             where TABID is not null) loop
    v_info := i.info;
    v_tab  := i.TABID;
    if v_info = 'ҩƷ��Ϣ����' then
     v_type:='1';
    end if;
    if v_info = '������Ŀ����' then
     v_type:='2';
    end if;
    if v_info = '������ʩ����' then
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
