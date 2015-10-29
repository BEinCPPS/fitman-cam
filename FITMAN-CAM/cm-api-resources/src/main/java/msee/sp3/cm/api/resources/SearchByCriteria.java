package msee.sp3.cm.api.resources;

import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;
import java.util.Date;

/**
 * A definition of search criteria for complex searches. The criteria may include:
 * <ul>
 *     <li>Date constraints: only return offerings valid within the time-span provided
 *     as arguments {@code validFrom} - {@code validThrough}, (i.e. offering.validFrom 
 *     < validFrom < validThrough < offering.validThrough)</li>
 *     <li>Price constraint: only return offerings with a price component which has value
 *     up to {@code valueUpTo} in given {@code currency}.</li>
 * </ul>
 * In order to enforce the price constraint, search implementation may have to use currency
 * converter service to convert among currencies.
 */
@XmlRootElement(name = "searchCriteria")
public class SearchByCriteria {

    /**
     * Date constraint
     */
    private Date validFrom, validThrough;

    /**
     * Price constraint
     */
    private String currency;
    private BigDecimal valueUpTo;

    public SearchByCriteria() {
    }

    public SearchByCriteria(Date validFrom, Date validThrough, String currency, BigDecimal valueUpTo) {
        this.validFrom = validFrom;
        this.validThrough = validThrough;
        this.currency = currency;
        this.valueUpTo = valueUpTo;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidThrough() {
        return validThrough;
    }

    public void setValidThrough(Date validThrough) {
        this.validThrough = validThrough;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public BigDecimal getValueUpTo() {
        return valueUpTo;
    }

    public void setValueUpTo(BigDecimal valueUpTo) {
        this.valueUpTo = valueUpTo;
    }

    @Override
    public String toString() {
        return "SearchByCriteria{" +
                "validFrom=" + validFrom +
                ", validThrough=" + validThrough +
                ", currency='" + currency + '\'' +
                ", valueUpTo=" + valueUpTo +
                '}';
    }
}
