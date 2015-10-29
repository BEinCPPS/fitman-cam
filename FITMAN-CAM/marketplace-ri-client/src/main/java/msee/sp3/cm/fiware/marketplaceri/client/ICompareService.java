package msee.sp3.cm.fiware.marketplaceri.client;

import org.fiware.apps.marketplace.model.ComparisonResult;

/**
 *
 */
public interface ICompareService {

    public static final String COMPARE_SERVICE_PREFIX = "v1/compare/";

    ComparisonResult compareSingle(String sourceServiceId);
}
