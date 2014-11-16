import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by Aravind Selvan on 11/16/14.
 */
public class HMM2 {
    private static String h = "H", l = "L", a = "A", c = "C", g = "G", t = "T", finalString;
    private static HashMap<String, HashMap<String, Double>> state = new HashMap<String, HashMap<String, Double>>();
    private static HashMap<String, List<HashMap<String, Double>>> transition = new HashMap<String, List<HashMap<String, Double>>>();
    private static HashMap<String, Double> initial = new HashMap<String, Double>();
    private static HashMap<String, Double> memoized = new HashMap<String, Double>();
    private static double sum = 0.0, globalMinimum = Double.MIN_VALUE;


    //private static String pattern = "GGCA";
    private static String pattern = "GGCACTGAA";

    public static void main(String[] args) {
        HashMap<String, Double> temp = new HashMap<String, Double>();

        temp.put(a, 0.2);
        temp.put(c, 0.3);
        temp.put(g, 0.3);
        temp.put(t, 0.2);
        state.put(h, temp);

        HashMap<String, Double> temp2 = new HashMap<String, Double>();
        temp2.put(a, 0.3);
        temp2.put(c, 0.2);
        temp2.put(g, 0.2);
        temp2.put(t, 0.3);
        state.put(l, temp2);


        ArrayList<HashMap<String, Double>> a = new ArrayList<HashMap<String, Double>>();
        HashMap<String, Double> a1 = new HashMap<String, Double>();
        a1.put(h, 0.5);
        a1.put(l, 0.5);
        a.add(a1);
        ArrayList<HashMap<String, Double>> b = new ArrayList<HashMap<String, Double>>();
        HashMap<String, Double> b1 = new HashMap<String, Double>();
        b1.put(h, 0.4);
        b1.put(l, 0.6);
        b.add(b1);
        transition.put(h, a);
        transition.put(l, b);

        initial.put(h, 0.5);
        initial.put(l, 0.5);

        Iterator initialIterator = initial.entrySet().iterator();
        while (initialIterator.hasNext()) {
            Map.Entry pairs = (Map.Entry) initialIterator.next();
            String currentString = (String) pairs.getKey();
            findPaths(new StringBuilder(""), currentString, 0, 0.5);
        }
        System.out.println("sum:" + sum + " ,globalMinimum:" + globalMinimum + " ,finalString:" + finalString);

    }

    private static Double findPaths(StringBuilder previous, String currentString, int i, double probability) {
        HashMap<String, Double> now = state.get(currentString);
        if (i < pattern.length()) {
            if (now.containsKey(pattern.charAt(i) + "")) {
                Double currentProbability = now.get(pattern.charAt(i) + "");
                probability *= currentProbability;
                StringBuilder previousString = new StringBuilder(previous).append(currentString);
                System.out.println("previous:" + previousString + " currentString:" + currentString + " currentProbability:" + currentProbability + " probability:" + probability);
                HashMap<String, Double> o = transition.get(currentString).get(0);
                Iterator it = o.entrySet().iterator();
                while (it.hasNext()) {
                    Map.Entry pairs = (Map.Entry) it.next();
                    System.out.print("transition:" + pairs.getValue());
                    Double retValue = findPaths(previousString, (String) pairs.getKey(), i + 1, probability * (Double) pairs.getValue());
                    System.out.println("retValue:" + retValue);
                    if ((i) == pattern.length() - 1) {
                        if (retValue > globalMinimum) {
                            globalMinimum = retValue;
                            finalString = previousString.toString() + currentString;
                        }
                        sum += retValue;
                    }
                }
            } else {
                return 0.0;
            }
        }
        return probability;
    }
}
