//You will fill in the functions marked with //TODO in this file
//You will also implement your own matrix stack
import java.util.*;

LinkedList<Mat4> s;
int drawing;
int numPts;
float k;
int persp;
float left;
float right;
float top;
float bottom;
float fov;
Vec3[] pts = new Vec3[2];
void gtInitialize() { 
  s = new LinkedList<Mat4>();
  s.add(new Mat4());
}

void gtPushMatrix() {
  s.add((Mat4)s.get(s.size() - 1));
}

void gtPopMatrix() { 
  if(s.size() > 1)
  {
     s.removeLast(); 
  }
  else
  {
     println("Cannot pop element off stack of size 1"); 
  }
}

/******************************************************************************
Tranfsormations: These functions apply a transformation to the Current Transformation Matrix. 
Use the methods you wrote in the math file to do so.
******************************************************************************/
//TODO
void gtTranslate(float tx, float ty, float tz) {
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 transMat = lastEntry.translateMat(tx, ty, tz);
  s.set(size, lastEntry.mult(transMat));
}
//TODO
void gtScale(float sx, float sy, float sz) { 
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 scaleMat = lastEntry.scaleMat(sx, sy, sz);
  s.set(size, lastEntry.mult(scaleMat));
}
//TODO
void gtRotate(float theta, float x, float y, float z) {
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 rotMat = lastEntry.rotateMat(theta, x, y, z);
  s.set(size, lastEntry.mult(rotMat));
}
//TODO
void gtRotateX(float theta) {
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 rotMat = lastEntry.rotateXMat(theta);
  s.set(size, lastEntry.mult(rotMat));
}
//TODO
void gtRotateY(float theta) {
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 rotMat = lastEntry.rotateYMat(theta);
  s.set(size, lastEntry.mult(rotMat));
}
//TODO
void gtRotateZ(float theta) {
  int size = s.size() - 1;
  Mat4 lastEntry = (Mat4)s.get(size);
  Mat4 rotMat = lastEntry.rotateZMat(theta);
  s.set(size, lastEntry.mult(rotMat));
}


void gtOrtho(float left, float right, float bottom, float top) {
  persp = 1;
  this.left = left;
  this.right = right;
  this.top = top;
  this.bottom = bottom;
}

//TODO
void gtPerspective(float fov) {
  float rad = (fov * PI) / 180;
  this.fov = fov;
  //fov = (0.5*PI) - (0.5 * rad);
  this.k = tan(rad/2);
  this.left = -k;
  this.right = k;
  this.top = k;
  this.bottom = -k;
  persp = 2;
}

void gtBeginShape() {
  drawing = 1;
}

void gtEndShape() {
  drawing = 0;
}

void gtVertex(float x, float y, float z) {
  if(drawing == 1)
  {
    pts[numPts % 2] = new Vec3(x, y, z);
    pts[numPts % 2] = ((Mat4)s.get(s.size() - 1)).mult(pts[numPts % 2]);
    if(persp == 2)
    {
        pts[numPts % 2].x *= -1/(pts[numPts % 2].z);
        pts[numPts % 2].y *= -1/(pts[numPts % 2].z);
        pts[numPts % 2].z = 1;
    }
    if(persp == 1)
    {
      pts[numPts % 2].z = 0;
    }
      pts[numPts % 2].x += (-left);
      pts[numPts % 2].y += (-bottom);
      pts[numPts % 2].x *= width/((right-left));
      pts[numPts % 2].y *= height/((top-bottom));
    if(numPts % 2 == 1) draw_line(pts[0].x, pts[0].y, pts[1].x, pts[1].y); 
    numPts++;
  }
}

void printStack() {
  for(int i = 0; i < s.size(); i++) {
    println("M" + i);
    println(s.get(i).toString());
  } 
}
