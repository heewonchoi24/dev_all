package org.ssis.pss.cmn.model;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.log4j.Logger;

@SuppressWarnings({ "serial", "rawtypes" })
public class ZValue extends ListOrderedMap implements java.io.Serializable
{ 
	 
	@SuppressWarnings("unchecked")
	public HashMap<String, String> columnNameWithClassType = new HashMap();
	public HashMap<String, Object> columnNameWithValueObject = null;
	public ArrayList<HashMap> rsSet = null; 

	protected Logger log = Logger.getLogger(this.getClass());
	
    protected String name = null;

    public ZValue()
    {
    }

	public ZValue(String name) {
		this.name = name;
	}

    @Override
    public Object get(Object s)
    {   
    	Object obj = super.get(s);
    	if(obj == null)
    		obj = "";
    	return obj;
    }

    public String getValue(String s)
    {
        return getString(s);
    }
    
    

    public boolean getBoolean(String s)
    {
        String s1 = getString(s);
        boolean flag = false;
        try
        {
            flag = (new Boolean(s1)).booleanValue();
        }
        catch(Exception exception) { }

        return flag;
    }

    public double getDouble(String s)
    {
        String s1 = removeComma(getString(s));
        if(s1.equals(""))
            return 0.0D;
        double d = 0.0D;
        try
        {
            d = Double.valueOf(s1).doubleValue();
        }
        catch(Exception exception)
        {
            d = 0.0D;
        }

        return d;
    }

    public float getFloat(String s)
    {
        return (float)getDouble(s);
    }

    public int getInt(String s)
    {
        double d = getDouble(s);
        return (int)d;
    }
    
    public int getInt(String s, int initVal)
    {
    	int ret = getInt(s);
    	if(ret == 0)
    		ret = initVal;
    	return ret;
    }

    public long getLong(String s)
    {
        String s1 = removeComma(getString(s));
        if(s1.equals(""))
            return 0L;
        long l = 0L;
        try
        {
            l = Long.valueOf(s1).longValue();
        }
        catch(Exception exception)
        {
            l = 0L;
        }

        return l;
    }

    public String getString(String s)
    {
        String s1 = null;
        try
        {
            Object obj = super.get(s);
            Class class1 = obj.getClass();

            if(class1.isArray())
            {
                int i = Array.getLength(obj);
                if(i == 0)
                {
                    s1 = "";
                }
                else
                {
                    Object obj1 = Array.get(obj, 0);
                    if(obj1 == null)
                        s1 = "";
                    else
                        s1 = obj1.toString();
                }
            }
            else
            {
                s1 = obj.toString();
            }
        }
        catch(Exception exception)
        {
            s1 = "";
        }

        return s1.trim();
    }

    @SuppressWarnings("unchecked")
	public Vector getVector(String s)
    {
        Vector vector = new Vector();
        try
        {
            Object obj = super.get(s);
            Class class1 = obj.getClass();
            if(obj != null)
            {
                if(class1.isArray())
                {
                    int i = Array.getLength(obj);
                    if(i != 0)
                    {
                        for(int j = 0; j < i; j++)
                        {
                            Object obj1 = Array.get(obj, j);
                            if(obj1 == null)
                                vector.addElement("");
                            else
                                vector.addElement(obj1.toString());
                        }
                    }
                }
                else
                {
                    vector.addElement(obj.toString());
                }
            }
        }
        catch(Exception exception) { }

        return vector;
    }

    @SuppressWarnings("unchecked")
	public java.util.ArrayList getArrayList(String s)
    {
        java.util.ArrayList al = new java.util.ArrayList();
        try
        {
            Object obj = super.get(s);
            Class class1 = obj.getClass();
            if(obj != null)
            {
                if(class1.isArray())
                {
                    int i = Array.getLength(obj);
                    if(i != 0)
                    {
                        for(int j = 0; j < i; j++)
                        {
                            Object obj1 = Array.get(obj, j);
                            if(obj1 == null)
                                al.add("");
                            else
                                al.add(obj1.toString());
                        }
                    }
                }
                else
                {
                    al.add(obj.toString());
                }
            }
        }
        catch(Exception exception) { }

        return al;
    }

    @SuppressWarnings("unchecked")
	public void put(String s, String s1)
    {
        super.put(s, s1);
    }

    @SuppressWarnings("unchecked")
	public void put(String s, java.util.ArrayList al)
    {
        String as[] = new String[al.size()];
        for(int i = 0; i < al.size(); i++) {
            if( al.get(i) != null )
                as[i] = (String)al.get(i);
            else
                as[i] = "";
        }

        super.put(s, as);
    }

    @SuppressWarnings("unchecked")
	public void putVector(String s, Vector vector)
    {
        String as[] = new String[vector.size()];
        for(int i = 0; i < vector.size(); i++)
            as[i] = vector.get(i) != null ? vector.get(i).toString() : "";

        put(s, as);
    }

    protected static String removeComma(String s)
    {
        if(s == null)
            return null;
        if(s.indexOf(",") != -1)
        {
            StringBuffer stringbuffer = new StringBuffer();
            for(int i = 0; i < s.length(); i++)
            {
                char c = s.charAt(i);
                if(c != ',')
                    stringbuffer.append(c);
            }

            return stringbuffer.toString();
        }
        else
        {
          return s;
        }
    }

    @SuppressWarnings("unchecked")
	public void setValue(String s, String s1)
    {
        super.put(s, s1);
    }

    @SuppressWarnings("unchecked")
	public void setVector(String s, Vector vector)
    {
        String as[] = new String[vector.size()];
        for(int i = 0; i < vector.size(); i++)
            as[i] = vector.get(i) != null ? vector.get(i).toString() : "";

        put(s, as);
    }

    @SuppressWarnings("unchecked")
	public void set(String s, String s1)
    {
        super.put(s, s1);
    }

    @SuppressWarnings("unchecked")
	public void set(String s, java.util.ArrayList al)
    {
        String as[] = new String[al.size()];
        for(int i = 0; i < al.size(); i++){
            if(al.get(i) != null)
                as[i] = (String)al.get(i);
            else
                as[i] = "";
        } 
        put(s, as);
    }
    

	@SuppressWarnings("unchecked")
	public String getJSONValue() {
		org.json.simple.JSONObject jObj = new org.json.simple.JSONObject( );
		Iterator it = this.keySet().iterator();
		while(it.hasNext()){
			String name = (String)it.next();
			Object obj = get(name);
			String value = null;
			if(obj instanceof String[])
			{
				obj = getArrayList(name);
				value = ZValue.arrayListToDelimitedString((ArrayList)obj, "|");
			}
			else
			{
				value = getString(name);
			}
			jObj.put(name, value);
		}
	    return(jObj.toString( ));
	}
	
	@SuppressWarnings("unchecked")
	public static String getArrayJSONValue(List<ZValue> zvalueList)
	{
		HashMap<String, ArrayList<String>> container = new HashMap<String, ArrayList<String>>();
		ZValue zvl;
		// for(ZValue zvl : zvalueList)
		for ( int i = 0; i < zvalueList.size(); i++ )
		{
			
			zvl = zvalueList.get(i);
			Iterator it = zvl.keySet().iterator();
			while(it.hasNext()){
				String name = (String)it.next();
				String value = zvl.getString(name);
				ArrayList<String> valueList = container.get(name);
				if(valueList == null)
				{
					valueList = new ArrayList<String>();
					valueList.add(value);
					container.put(name, valueList);
				}
				else
				{
					valueList.add(value);
				}
			}
		}

		org.json.simple.JSONObject jObj = new org.json.simple.JSONObject( );
		Iterator it = container.keySet().iterator();
		while(it.hasNext()){
			String name = (String)it.next();
			String value = ZValue.arrayListToDelimitedString(container.get(name), "|");
			jObj.put(name, value);
		}
	    return(jObj.toString( ));
	}

    private static String arrayListToDelimitedString(ArrayList arr, String delim) {
        if (arr == null)
            return "null";
        else {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < arr.size(); i++) {
                if (i > 0)
                    sb.append(delim);
                sb.append(arr.get(i));
            }
            return sb.toString();
        }
    }

    @Override
    public String toString()
    {
    	StringBuffer result = new StringBuffer();
    	result.append("{");
    	Iterator it = keySet().iterator();
    	while(it.hasNext())
    	{
    		String key = (String)it.next();
    		String value = getValue(key);
    		result.append("("+key+","+value+")\n");
    	}
    	result.append("}");
    	return result.toString();
    } 
	
	public String getSplitArrayString(String s,String tk, int i){
		String temp, val = "";
		temp = getString(s);
		if (getString(s).indexOf(tk)>-1){
			String[] tempArr = temp.split("\\"+tk);
			if (tempArr.length>i) {val=tempArr[i];} else {val="";}
		} else {
			val = temp;
		}
		return val;
	}
	 
    @SuppressWarnings("unchecked")
	public static void main(String[] args)throws Exception{
    	
    	ZValue zvl1 = new ZValue();
    	zvl1.put("k1", 100);
    	zvl1.put("k2", "v12");
    	zvl1.put("k3", "v12");

    	ZValue zvl2 = new ZValue();
    	zvl2.put("k1", "v21");
    	zvl2.put("k2", "v22");
    	zvl2.put("k3", "v22");

    	ZValue zvl3 = new ZValue();
    	zvl3.put("k1", "v31");
    	zvl3.put("k2", "v32");
    	zvl3.put("k3", "v32");
    	
    	if( zvl3.containsKey("k1") & zvl3.containsValue("v30") );
    	
    	ArrayList<ZValue> list = new ArrayList<ZValue>();
    	list.add(zvl1);
    	list.add(zvl2);
    	list.add(zvl3);
    	
    	ArrayList<ZValue> out = new ArrayList<ZValue>();
    	for( int i=0; i < list.size()-1; i++ ) {
    		String v = (String) list.get(i).get("k1");
    		ZValue z = new ZValue();
    		z.put("k1", v);
    		out.add( z );
    	} 
    }
    

    public List<String> keyList(){
    	return super.keyList();
    }
    
    public List<Object> valueList(){
    	return super.valueList();
    }

}