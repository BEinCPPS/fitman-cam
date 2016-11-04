package it.eng.ontorepo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ascatolo on 03/11/2016.
 */
public class IndividualtemTransformer {


    public static List<IndividualItemWrapper> transformAll(List<IndividualItem> individuals, boolean brokenDomain) {
        List<IndividualItemWrapper> individualItemWrappers = new ArrayList<>();
        if (individuals == null) return null;
        for (IndividualItem individual :
                individuals) {
            individualItemWrappers.add(transform(individual, brokenDomain));
        }
        return individualItemWrappers;
    }

    public static IndividualItemWrapper transform(IndividualItem individual, boolean brokenDomain) {
        return new IndividualItemWrapper(individual, brokenDomain);
    }


}
