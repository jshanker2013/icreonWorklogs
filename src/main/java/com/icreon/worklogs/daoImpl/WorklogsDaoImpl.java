package com.icreon.worklogs.daoImpl;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.icreon.mail.SendMail;
import com.icreon.user.UserDetails;
import org.hibernate.*;

import com.icreon.util.HibernateUtil;

public class WorklogsDaoImpl {
	
	public List showSelectedWorklogs(String issue)
	{
		

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_issue_ID(:p_issue_id)")
				.setParameter("p_issue_id",issue);
				
	//	query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public List showSelectedWorklogsWrtUser(String issue,String username)
	{
		

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_issue_user(:p_issue_id,:p_author)")
				.setParameter("p_issue_id",issue)
				.setParameter("p_author",username)
				;
				
//		query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public List showSelectedWorklogsWrtOnlyUser(String username)
	{
		

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_user(:p_author)")
				
				.setParameter("p_author",username)
				;
				
		//query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public List showSelectedWorklogsWrtOnlyDate(String fromDate,String toDate)
	{
		
System.out.println("Start date is"+fromDate);
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_date(:p_from_date,:p_to_date)")
				
				.setParameter("p_from_date",fromDate.trim())
				.setParameter("p_to_date",toDate.trim())
				;
				
	//	query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public List showSelectedWorklogsWrtAll(String issue,String username,String fromDate,String toDate)
	{
		
System.out.println("Start date is"+fromDate);
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_all(:p_issue_id,:p_author,:p_from_date,:p_to_date)")
				.setParameter("p_issue_id",issue)
				.setParameter("p_author",username)
				.setParameter("p_from_date",fromDate)
				.setParameter("p_to_date",toDate)
				;
				
	//	query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public List showSelectedWorklogsWrtAllAndStatus(String issue,String username,String fromDate,String toDate,int status)
	{
		
System.out.println("Start date is"+fromDate);
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getWorklogs_wrt_all_and_status(:p_issue_id,:p_author,:p_from_date,:p_to_date,:p_status)")
				.setParameter("p_issue_id",issue)
				.setParameter("p_author",username)
				.setParameter("p_from_date",fromDate)
				.setParameter("p_to_date",toDate)
				.setParameter("p_status",status)
				;
				
	//	query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public void updateSelectedWorklog(String p_project_id,String p_worklog_id,String p_issue_id)
	{
		
		System.out.println("Update DAO");

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_setWorklogs_aprove_status(:p_project_id,:p_worklog_id,"
				+ ":p_issue_id)")
				.setParameter("p_project_id",p_project_id.trim())
				.setParameter("p_worklog_id",p_worklog_id.trim())
				.setParameter("p_issue_id",p_issue_id.trim())
				;
				
		query.executeUpdate();
		System.out.println("Query Executed");

		String to_status = "Approved";
		sendEmailNotification(p_project_id,p_issue_id,p_worklog_id,to_status);

		//List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		
	}
	
	public List approvedWorklog()
	{
		
		
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getApprovedWorklogs()");
				
	//	query.executeUpdate();
		System.out.println("Query Executed");
		List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		return list;
	}
	
	public List unApprovedWorklog()
	{
		
		
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getUnApprovedWorklogs()");
				
		//query.executeUpdate();
		System.out.println("Query Executed");
		List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		return list;
	}
	
	
	public List showSelectedAuthors(String issue)
	{

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getAuthors(:p_issue_id)")
				.setParameter("p_issue_id",issue);
				
	//	query.executeUpdate();
		List<Object[]> list=query.list();
		
		session.close();
		 return list;
		
	}
	
	public int approveAllWorklogs(String p_worklog_id)
	{
		
		System.out.println("Update DAO");

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_approveAll(:p_worklog_id)")
				.setParameter("p_worklog_id",p_worklog_id.trim());
				
		query.executeUpdate();
		System.out.println("Query Executed");
		//List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 return 1;
		
	}
	
	public List showRejectedWorklog()
	{
		
		
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getRejectedWorklogs()");
				
		//query.executeUpdate();
		System.out.println("Query Executed");
		List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		return list;
	}
	
	
	public void updateRejectedWorklog(String p_project_id,String p_worklog_id,String p_issue_id)
	{
		
		System.out.println("Update DAO");

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_setWorklogs_rejected_to_aprove_status(:p_project_id,:p_worklog_id,"
				+ ":p_issue_id)")
				.setParameter("p_project_id",p_project_id.trim())
				.setParameter("p_worklog_id",p_worklog_id.trim())
				.setParameter("p_issue_id",p_issue_id.trim())
				;
				
		query.executeUpdate();
		System.out.println("Query Executed");

		String to_status = "Approved";
		sendEmailNotification(p_project_id,p_issue_id,p_worklog_id,to_status);

		//List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		
	}
	
	
	public void updateSelectedWorklogStatusTORejected(String p_project_id,String p_worklog_id,String p_issue_id)
	{
		
		System.out.println("Update DAO");

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_setWorklogs_reject_status(:p_project_id,:p_worklog_id,"
				+ ":p_issue_id)")
				.setParameter("p_project_id",p_project_id.trim())
				.setParameter("p_worklog_id",p_worklog_id.trim())
				.setParameter("p_issue_id",p_issue_id.trim())
				;
				
		query.executeUpdate();
		System.out.println("Query Executed");

		String to_status = "Rejected";
		sendEmailNotification(p_project_id,p_issue_id,p_worklog_id,to_status);

		//List<Object[]> list=query.list();
		tx.commit();
		session.close();
		 
		
	}

	public void sendEmailNotification(String p_project_id,String p_issue_id,String p_worklog_id,String to_status){

		UserDetails userDetails = new UserDetails();
		Map userMap =  userDetails.getUserEmailId(p_issue_id);

		SendMail sendMail = new SendMail();
		boolean status = sendMail.prepare_mail(p_project_id,userMap,p_worklog_id,to_status);

		if(status == true){
			System.out.println("Notified by email notification");
		}
		else
			System.out.println("Something went wrong while Sending notification..");

	}

	public List lastWeekLogs(){
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		LocalDate todaysDate = LocalDate.now();
		System.out.println("todays date is = " +todaysDate);
		LocalDate dateMinus7days=todaysDate.minusDays(7);
		System.out.println("Date after substracting 7 days = "+todaysDate.minusDays(7));
		//String hql = "select * from tbl_worklogs w where (w.start_date >="+"'"+dateMinus7days+"'"+")"+"and (w.start_date <="+"'"+todaysDate+"'"+")";
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where (w.start_date >="+"'"+dateMinus7days+"'"+")"+"and (w.start_date <="+"'"+todaysDate+"'"+")";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> weeklyLogList=query.list();
		//	weeklyLogList.toString();
		tx.commit();
		session.close();

		return weeklyLogList;
	}

	public List showLastSevenDaysWorklogs() {

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session = sf.openSession();
		Transaction tx = session.beginTransaction();
		SQLQuery query = (SQLQuery) session.createSQLQuery("call pro_getLastSevenDaysWorklogs()");

		//query.executeUpdate();

		List<Object[]> list = query.list();
		tx.commit();
		session.close();

		return list;
	}

	public List worklogWithUserFromDate(String issue, String user, String fromDate){
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.author='"+user+"' and w.start_date>='"+fromDate+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyUserAndFromDateList=query.list();
		//	weeklyLogList.toString();
		tx.commit();
		session.close();

		return onlyUserAndFromDateList;
	}

	public List worklogWithUserToDate(String issue, String user,String toDate) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.author='"+user+"' and w.start_date<='"+toDate+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyUserAndToDateList=query.list();
		tx.commit();
		session.close();

		return onlyUserAndToDateList;
	}

	public List worklogWithUserFromToToDate(String issue, String user, String fromDate, String toDate) {

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.author='"+user+"' and (w.start_date>='"+fromDate+"' and w.start_date<='"+toDate+"')";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyUserAndToDateList=query.list();
		tx.commit();
		session.close();

		return onlyUserAndToDateList;
	}

	public List worklogWithUserwithOnlyStatus(String issue, String user, int status) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.author='"+user+"' and w.status='" +status+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyUserAndStatusList=query.list();
		tx.commit();
		session.close();

		return onlyUserAndStatusList;
	}

	public List worklogWithOnlyStatus(String issue, int status) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.status='" +status+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndStatusList=query.list();
		tx.commit();
		session.close();

		return onlyIssueAndStatusList;
	}

	public List<Object[]> WorklogIssueWithTwoDates(String issue, String fromDate, String toDate) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and (w.start_date>='"+fromDate+"' and w.start_date<='"+toDate+"')";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndTWoDatesList=query.list();
		tx.commit();
		session.close();

		return onlyIssueAndTWoDatesList;
	}

	public List worklogWithStatusDates(String issue, String fromDate, String toDate, int status) {

		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and (w.start_date>='"+fromDate+"' and w.start_date<='"+toDate+"')and w.status="+"'"+status+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndTWoDatesList=query.list();
		tx.commit();
		session.close();

		return onlyIssueAndTWoDatesList;
	}

	public List worklogswithIssueAndFromDate(String issue, String fromDate) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.start_date>='"+fromDate+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndTWoDatesList=query.list();
		tx.commit();
		session.close();

		return onlyIssueAndTWoDatesList;
	}

	public List worklogWithAll(String issue, String user, String fromDate, String toDate, int status) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and (w.start_date>='"+fromDate+"' and w.start_date<='"+toDate+"') and w.author='"+user+"' and w.status='"+status+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndTWoDatesList=query.list();
		tx.commit();
		session.close();

		return onlyIssueAndTWoDatesList;
	}

	public List WorklogIssueWithOnlyFromDate(String issue, String fromDate) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.start_date>='"+fromDate+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndFromDateList=query.list();
		//	weeklyLogList.toString();
		tx.commit();
		session.close();

		return onlyIssueAndFromDateList;
	}

	public List WorklogIssueWithOnlyToDate(String issue, String toDate) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and w.start_date<='"+toDate+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueAndToDateList=query.list();
		//	weeklyLogList.toString();
		tx.commit();
		session.close();

		return onlyIssueAndToDateList;
	}

	public List worklogWithUserToDateAndStatus(String issue, String user, String toDate, int status) {
		SessionFactory sf = HibernateUtil.getSessionFactory();
		Session session=sf.openSession();
		Transaction tx=session.beginTransaction();
		String hql = "select w.project_id,w.issue_id,w.worklog_id,w.start_date,w.description,w.author,w.time_spent,w.status,w.date_created from tbl_worklogs w where w.issue_id ="+"'"+issue+"' and ( w.start_date<='"+toDate+"') and w.author='"+user+"' and w.status='"+status+"'";
		Query query = session.createSQLQuery(hql);
		System.out.println("Query Executed");
		List<Object[]> onlyIssueToDateAndStatusList=query.list();
		tx.commit();
		session.close();

		return onlyIssueToDateAndStatusList;
	}

	public LocalDate dayMinusSeven(){

		LocalDate todaysDate = LocalDate.now();

		LocalDate dayMinus_7=todaysDate.minusDays(7);
		return dayMinus_7;
	}
}
