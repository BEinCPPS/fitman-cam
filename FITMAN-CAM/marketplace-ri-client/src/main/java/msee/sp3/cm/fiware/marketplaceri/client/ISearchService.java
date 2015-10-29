package msee.sp3.cm.fiware.marketplaceri.client;

import org.fiware.apps.marketplace.model.SearchByCriteria;
import org.fiware.apps.marketplace.model.SearchResultEntry;
import org.fiware.apps.marketplace.model.SearchResultOffering;

import java.util.List;

/**
 * @since 5/5/13 23:30
 */
public interface ISearchService {

    public static final String SEARCH_SERVICE_PREFIX = "v1/search";
    public static final String FULLTEXT_SEARCH = "/offerings/fulltext";
    public static final String CRITERIA_SEARCH = "/offerings/criteria";

    List<SearchResultEntry> search(String searchstring);

    SearchResultOffering findOfferingsByCriteria(SearchByCriteria searchByCriteria);
}
