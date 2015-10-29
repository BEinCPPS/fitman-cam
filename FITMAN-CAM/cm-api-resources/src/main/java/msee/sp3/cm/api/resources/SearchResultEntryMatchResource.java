package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "match")
public class SearchResultEntryMatchResource {
	private String text;
	private float luceneScore;
	private String literal;
	
	
	public SearchResultEntryMatchResource(){
	}
	
	public SearchResultEntryMatchResource(String text, float luceneScore) {
		this.text = text;
		this.luceneScore = luceneScore;
	}
	
	
	@XmlElement
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}	

	@XmlElement
	public float getLuceneScore() {
		return luceneScore;
	}
	public void setLuceneScore(float luceneScore) {
		this.luceneScore = luceneScore;
	}
	
	
	@XmlElement
	public String getLiteral() {
		return literal;
	}

	public void setLiteral(String literal) {
		this.literal = literal;
	}
}
