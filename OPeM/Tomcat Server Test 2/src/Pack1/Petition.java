package Pack1;

import java.util.ArrayList;

public class Petition {

	public long id;
	public String title;
	public String description;
	public String category;
	public long target;
	public long votes;
	public ArrayList<String> tags;
	public String tags2;
	public String name;
	public String email;
	public String creDate;
	public String expDate;
	
	public Petition(String cat,String titl,String desc, long trg,long v,String tgs,String nm,String eml,String expiration)
	{
		category=cat;
		title=titl;
		description=desc;
		votes=v;
		target=trg;
		name=nm;
		email=eml;
		tags2=tgs;
		expDate=expiration.substring(0,10);
	}
	
	public Petition(long id,String cat,String titl,String desc, long trg,long v,String tgs,String nm,String eml,String creation, String expiration)
	{
		this.id=id;
		category=cat;
		title=titl;
		description=desc;
		votes=v;
		target=trg;
		name=nm;
		email=eml;
		tags2=tgs;
		creDate=creation;
		expDate=expiration.substring(0,10);
	}
	
	public void getTags()
	{
		for(int i=0;i<tags.size();i++)
			System.out.println(tags.get(i));
	}
	
	public void bucatalesteTaguri(String tags)
	{
		while(tags!=null)
		{
			ArrayList<String> tags2=new ArrayList<String>();
			String tag;
			tag=extractWord(tags);
			tags2.add(tag);
			if(tags.equalsIgnoreCase((skipWhiteSpaces(tags.substring(tag.length())))))
				tags=null;
			else
				tags=skipWhiteSpaces(tags.substring(tag.length()));
			
		}
	}
	
	static String skipWhiteSpaces(String request)
    {
    	int i=0;
    	if(request.length()==0)
    		return null;
    	while(request.charAt(i)==' ')
    		i++;
    	return request.substring(i);
    			
    }
    
   static String extractWord(String request)
    {
    	request=skipWhiteSpaces(request);
    	for(int i=0;i<request.length();i++)
    		if(request.charAt(i)==' ')
    			return request.substring(0,i);
    	return request;
    }
	
}
