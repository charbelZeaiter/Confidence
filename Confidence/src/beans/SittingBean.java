package beans;

public class SittingBean {
	
	private int id;
	private String name;
	private String pwd;
	private String status;
	
	public SittingBean(int aId, String aName, String aPwd, String status) {
		this.id = aId;
		this.name = aName;
		this.pwd = aPwd;
		this.status = status;
	}
	
	public int getId()
	{
		return this.id;
	}
	
	public void setId(int aId)
	{
		this.id = aId;
	}
	
	public String getName()
	{
		return this.name;
	}
	
	public void setName(String aName)
	{
		this.name = aName;
	}
	
	public String getPwd()
	{
		return this.pwd;
	}
	
	public void setPwd(String aPwd)
	{
		this.pwd = aPwd;
	}
	
	public String getStatus()
	{
		return this.status;
	}
	
	public void setStatus(String status)
	{
		this.status = status;
	}
}
