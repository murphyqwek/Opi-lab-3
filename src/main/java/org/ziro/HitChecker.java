package org.ziro;



public class HitChecker {

    public boolean isHit(double r, double x, double y) {
        if (x >= 0 && y >= 0) {
            double radius = r / 2.0;
            if (x * x + y * y <= radius * radius) {
                return true;
            }
        }


        if (x <= 0 && y >= 0) {

            if (y <= x + r) {
                return true;
            }
        }

        if (x >= -r && x <= 0 && y >= -r / 2.0 && y <= 0) {
            return true;
        }

        return false;
    }
}
