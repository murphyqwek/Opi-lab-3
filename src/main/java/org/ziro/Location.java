package org.ziro;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Location {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int id;
    public double x;
    public double y;
    public double r;
    public boolean hit;
    public String startTime;
    public double timerValue;

    public Location(double x, double y, double r, boolean hit, String startTime, double timerValue) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.hit = hit;
        this.startTime = startTime;
        this.timerValue = timerValue;
    }

    public Location() {

    }

    public int getId() {
        return id;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }
    public double getR() {
        return r;
    }

    public boolean isHit() {
        return hit;
    }

    public String getStartTime() {
        return startTime;
    }

    public double getExecutionTime() {
        return timerValue;
    }
}
