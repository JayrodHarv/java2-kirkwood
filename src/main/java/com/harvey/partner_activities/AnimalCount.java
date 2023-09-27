package com.harvey.partner_activities;

import java.util.*;
import java.util.stream.Collectors;

public class AnimalCount {
    public static void main(String[] args) {
        Map<Person, List<Animal>> owners_and_their_pets = new HashMap<>();

        Person marc = new Person("Marc");
        List<Animal> marcs_pets = new ArrayList<>() {{
            add(new Cat("Waffles"));
            add(new Cat("Sprout"));
        }};
        owners_and_their_pets.put(marc, marcs_pets);

        Person krystal = new Person("Krystal");
        List<Animal> krystal_pets = new ArrayList<>() {{
            add(new Cat("Todd"));
            add(new Cat("Margo"));
            add(new Dog("Gus"));
        }};
        owners_and_their_pets.put(krystal, krystal_pets);

        Person bob = new Person("Bob");
        List<Animal> bobs_pets = new ArrayList<>();
        owners_and_their_pets.put(bob, bobs_pets);

        Person amy = new Person("Amy");
        List<Animal> amys_pets = new ArrayList<>();
        amys_pets.add(new Cat("Zipper"));
        owners_and_their_pets.put(amy, amys_pets);

        Person jared = new Person("Jared");
        List<Animal> jareds_pets = new ArrayList<>() {{
            add(new Dog("Maya"));
            add(new Dog("Kyla"));
        }};
        owners_and_their_pets.put(jared, jareds_pets);


        Person julien = new Person("Julien");
        List<Animal> juliens_pets = new ArrayList<>() {{
            add(new Cat("Dash"));
            add(new Cat("Carl"));
            add(new Cat("Eleven"));
            add(new Cat("Rick"));
        }};
        owners_and_their_pets.put(julien, juliens_pets);


        for (Map.Entry entry: owners_and_their_pets.entrySet()) {
            Person person = (Person) entry.getKey();
            List<Animal> animals = (List<Animal>) entry.getValue();
            String animals2 = animals.stream().map(Object::toString).collect(Collectors.joining(","));
            String person2 = person.getFirstName();
            int count = animals.size();
            if (count == 0) {
                System.out.println(person2 + "has no pets.");
            } else if (count == 1) {
                System.out.println(person2 + "'s pet: " + animals2);
            } else {
                System.out.println(person2 + "'s pets: " + animals2);
            }
        }
        System.out.println();

        Map<String, Integer> counter = new HashMap<>();
        for(Map.Entry entry: owners_and_their_pets.entrySet()) {
            List<Animal> animals = (List<Animal>) entry.getValue();
            for(int i = 0; i < animals.size() - 1; i++) {
                String animalType = animals.get(i).getClass().getSimpleName();
                if (!counter.containsKey(animalType)) {
                    counter.put(animalType, 1);
                } else {
                    counter.put(animalType, counter.get(animalType) + 1);
                }
            }
        }
        counter.forEach((animal, count) -> System.out.println((count > 1) ? "There are " + count + " " + animal + "s" : "There is " + count + " " + animal));
    }
}
