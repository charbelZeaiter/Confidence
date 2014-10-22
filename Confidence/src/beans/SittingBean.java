package beans;

public class SittingBean {
	
	private int id;
	private String name;
	private String pwd;
	
	public SittingBean(int aId, String aName, String aPwd) {
		this.id = aId;
		this.name = aName;
		this.pwd = aPwd;
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
}
