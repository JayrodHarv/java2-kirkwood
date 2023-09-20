package com.harvey.day8;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class MyMaps {
    public static void main(String[] args) {
        Map<String, Integer> population = new HashMap<>();
        population.put("DesMoines", 1283912);
        population.put("Cedar Rapids", 8395803);
        population.put("Davenport", 83054980);
        population.put("Sioux City", 382920845);
        population.put("Cedar Rapids", 893485043);
        population.entrySet().forEach(System.out::println);
        System.out.println();
        population.forEach((city, size) -> System.out.println(city + ":" + size));
        System.out.println();
        for(Map.Entry entry: population.entrySet()) {
            System.out.println(entry.getKey() + "->" + entry.getValue());
        }
        System.out.println();
        for(String key: population.keySet()) {
            System.out.println(key + "--" + population.get(key));
        }


        Map<String, String> stateTrees = new TreeMap<>();
        stateTrees.put("kjskdfjs", "jskdfj;lsjd");
        stateTrees.put("jkdsfjd", "jiwoeapdlf");
        stateTrees.put("uwieuriosd", "woieprudks");
        stateTrees.put("jsdfuie", "pqpeorud");
        stateTrees.put("iusdifkw", "oqiakdjkjf9");

        Map<String, Integer> treeCount = new TreeMap<>();

        for(String state: stateTrees.keySet()) {
            String tree = stateTrees.get(state);
            if(!treeCount.containsKey(tree)) {
                // if first time seeing tree, add tree
                treeCount.put(tree, 1);
            } else {
                // if already exists in treeCount
                treeCount.put(tree, treeCount.get(tree) + 1);
            }
        }
        treeCount.entrySet().forEach(System.out::println);

        // count cats and dogs
        // generate arraylist that represents peoples pets
        // ex. mark has 2 pets
        // create loop that produces animal count
        // requires nested loops - one that loops through map - one for list



    }
}
