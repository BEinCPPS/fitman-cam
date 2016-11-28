package it.antonioscatoloni.model;



public class Name {
	
    private String title;
    private String first;
    private String last;
    
    
	public Name () {
		
	}	
        
    public Name (Json json) {
    
        this.title = json.optString("title");
        this.first = json.optString("first");
        this.last = json.optString("last");

    }
    
    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFirst() {
        return this.first;
    }

    public void setFirst(String first) {
        this.first = first;
    }

    public String getLast() {
        return this.last;
    }

    public void setLast(String last) {
        this.last = last;
    }


    
}
