package org.ziro;

import org.junit.Test;
import static org.junit.Assert.*;

public class HitCheckerTest {

    private final HitChecker checker = new HitChecker();

    @Test
    public void testFirstQuadrantHit() {
        assertTrue(checker.isHit(2.0, 0.5, 0.5));
    }
    @Test
    public void testFirstQuadrantMiss() {
        assertFalse(checker.isHit(2.0, 1.0, 1.0));
    }

    @Test
    public void testFirstQuadrantBorder() {
        assertTrue(checker.isHit(2.0, 1.0, 0.0));
    }
    @Test
    public void testSecondQuadrantHit() {
        assertTrue(checker.isHit(2.0, -1.0, 0.5));
    }

    @Test
    public void testSecondQuadrantMiss() {
        assertFalse(checker.isHit(2.0, -2.0, 1.0));
    }

    @Test
    public void testSecondQuadrantBorder() {
        assertTrue(checker.isHit(2.0, -1.0, 1.0));
    }
    @Test
    public void testThirdQuadrantHit() {
        assertTrue(checker.isHit(2.0, -1.0, -0.5));
    }

    @Test
    public void testThirdQuadrantMissX() {
        assertFalse(checker.isHit(2.0, -3.0, -0.5));
    }

    @Test
    public void testThirdQuadrantMissY() {
        assertFalse(checker.isHit(2.0, -1.0, -1.5));
    }

    @Test
    public void testThirdQuadrantBorder() {
        assertTrue(checker.isHit(2.0, -2.0, -1.0));
    }
    @Test
    public void testFourthQuadrantMiss() {
        assertFalse(checker.isHit(2.0, 1.0, -1.0));
    }
    @Test
    public void testOriginHit() {
        assertTrue(checker.isHit(2.0, 0.0, 0.0));
    }
}