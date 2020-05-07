//Vector Math Library
//Copy this .pde file into any future project directory to take this code with you!

//2x1 vector class
class Vec2{
  float x,y;
  
  //Constructors
  Vec2() {x=0; y=0;}
  Vec2(float _x, float _y){    x = _x; y = _y;  }
  Vec2(Vec2 v){    x=v.x; y=v.y;  }
  
  //Trivial math
  Vec2 plus(Vec2 v){     return new Vec2(x+v.x, y+v.y);  }
  Vec2 minus(Vec2 v){    return new Vec2(x-v.x, y-v.y);  }
  Vec2 mult(float s){    return new Vec2(x*s, y*s);      }
  Vec2 div(float s){     return new Vec2(x/s, y/s);      }
  
  //Vector math functions
  float dot(Vec2 v){
    return (this.x * v.x) + (this.y * v.y);
  }
  
  float norm(){
    return sqrt(this.dot(this));
  }
  
  float sqNorm(){
    return this.dot(this);
  }
  
  void normalize(){
    float normValue = this.norm();
    this.x /= normValue;
    this.y /= normValue;
  }
  
  Vec2 normalized(){
    Vec2 ret = new Vec2();
    float normValue = this.norm();
    if(this.x != 0 && this.y != 0)
    {
      ret = this.div(normValue);      
    }
    if(this.x == 0 && normValue != 0)
    {
       ret.y = ret.y / normValue; 
    }
    if(this.y == 0 && normValue != 0)
    {
       ret.x = ret.x / normValue; 
    }
    return ret;
  }
  
  //other trivial utilities
  String toString(){    return ("["+x+","+y+"]");  }
  boolean equalTo(Vec2 v){  return (x==v.x && y==v.y);  }
}


//3x1 vector class
class Vec3{
  float x,y,z;
  
  //Constructors
  Vec3() {x=0; y=0; z=0;}
  Vec3(float _x, float _y, float _z){    x = _x; y = _y; z = _z;  }
  Vec3(Vec3 v){    x=v.x; y=v.y; z=v.z; }
  
  //Trivial math
  Vec3 plus(Vec3 v){     return new Vec3(x+v.x, y+v.y, z+v.z);  }
  Vec3 minus(Vec3 v){    return new Vec3(x-v.x, y-v.y, z-v.z);  }
  Vec3 mult(float s){    return new Vec3(x*s, y*s, z*s);      }
  Vec3 div(float s){     return new Vec3(x/s, y/s, z/s);      }
  
  float dot(Vec3 v){
    return (this.x * v.x) + (this.y * v.y) + (this.z * v.z);
  }
  
  Vec3 cross(Vec3 v){
    Vec3 ret = new Vec3();
    ret.x = (this.y * v.z) - (this.z * v.y);
    ret.y = (this.z * v.x) - (this.x * v.z);
    ret.z = (this.x * v.y) - (this.y * v.x);
    return ret;
  }
  
  float norm(){
    return sqrt(this.dot(this));
  }
  
  float sqNorm(){
    return this.dot(this);
  }
  
  void normalize(){
    float normValue = this.norm();
    this.x /= normValue;
    this.y /= normValue;
    this.z /= normValue;
  }
  
  Vec3 normalized(){
    Vec3 ret = new Vec3();
    float normValue = this.norm();
    if(this.x != 0 && this.y != 0 && this.z != 0)
    {
      ret = this.div(normValue);      
    }
    if(Float.isNaN(this.x))
    {
       ret.x = 0;
    }
    if(Float.isNaN(this.y))
    {
       ret.y = 0;
    }
    if(Float.isNaN(this.z))
    {
       ret.z = 0;
    }
    return ret;
  }
  
  //other trivial utilities
  String toString(){    return ("["+x+","+y+","+z+"]");  }
  boolean equalTo(Vec3 v){  return (x==v.x && y==v.y && z==v.z);  }
}

class Mat3{
  private float[][] m;
  
  //constructors
  Mat3(){
    m = new float[3][3];
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        m[r][c] = r==c ? 1 : 0;
  }
  
  Mat3(Mat3 m0){
    m = new float[3][3];
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        m[r][c] = m0.get(r,c);
  }
  
  Mat3(float f0, float f1, float f2, float f3, float f4, float f5, float f6, float f7, float f8){
    m = new float[3][3];
    m[0][0] = f0; m[0][1] = f1; m[0][2] = f2;
    m[1][0] = f3; m[1][1] = f4; m[1][2] = f5;
    m[2][0] = f6; m[2][1] = f7; m[2][2] = f8;
  }
  
  //trivial math functions
  Mat3 mult(float s){
    Mat3 ret = new Mat3();
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        ret.set(r, c, m[r][c]*s);
    return ret;
  }
  Mat3 div(float s){
    Mat3 ret = new Mat3();
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        ret.set(r, c, m[r][c]/s);
    return ret;
  }
  
  //non-trivial math functions
  Mat3 transpose(){
    Mat3 ret = new Mat3();
    for(int i = 0; i < 3; i++)
    {
      for(int j = 0; j < 3; j++)
      {
        ret.m[i][j] = this.m[j][i]; 
      } 
    }
    return ret;
  }
  
  Mat3 mult(Mat3 m0){
    Mat3 ret = new Mat3();
    for (int i = 0; i < 3; i++)
    {
      ret.set(i, i, 0);
        for (int j = 0; j < 3; j++)
        {
            for (int k = 0; k < 3; k++)
            {
                ret.m[i][j] += (this.m[i][k] * m0.m[k][j]);
            }
        }
    }
    return ret;
  }
  
  Vec3 mult(Vec3 v){
    Vec3 ret = new Vec3();
    ret.x += (this.m[0][0] * v.x) + (this.m[0][1] * v.y) + (this.m[0][2] * v.z);
    ret.y += (this.m[1][0] * v.x) + (this.m[1][1] * v.y) + (this.m[1][2] * v.z);
    ret.z += (this.m[2][0] * v.x) + (this.m[2][1] * v.y) + (this.m[2][2] * v.z);
    return ret;
  }
  
  //other trivial utilities
  float get(int row, int col){ return m[row][col]; }
  void set(int row, int col, float val){ m[row][col] = val; }
  Vec3 getCol(int col){return new Vec3(m[0][col], m[1][col], m[2][col]);}
  Vec3 getRow(int row){return new Vec3(m[row][0], m[row][1], m[row][2]);}
  void setCol(int col, Vec3 v){m[0][col] = v.x; m[1][col] = v.y;  m[2][col] = v.z;}
  void setRow(int row, Vec3 v){m[row][0] = v.x; m[row][1] = v.y;  m[row][2] = v.z;}
  String toString(){    
    String s = "";
    for(int r=0; r<3; r++){
      s += "[";
      for(int c=0; c<3; c++){
        s+=m[r][c];
        if(c<2) s+= ",";
      }
      s += "]\n";
    }
    return s;
  }
  boolean equalTo(Mat3 m0){  
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        if(m[r][c] != m0.get(r,c))
          return false;
    return true;
  }
}

class Mat4{
  private float[][] m;
  
  //constructors
  Mat4(){
    m = new float[4][4];
    for(int r=0; r<4; r++)
      for(int c=0; c<4; c++)
        m[r][c] = r==c ? 1 : 0;
  }
  
  Mat4(Mat4 m0){
    m = new float[4][4];
    for(int r=0; r<4; r++)
      for(int c=0; c<4; c++)
        m[r][c] = m0.get(r,c);
  }
  
  Mat4(float f0, float f1, float f2, float f3, float f4, float f5, float f6, float f7, float f8, float f9, float f10, float f11, float f12, float f13, float f14, float f15){
    m = new float[4][4];
    m[0][0] = f0; m[0][1] = f1; m[0][2] = f2; m[0][3] = f3;
    m[1][0] = f4; m[1][1] = f5; m[1][2] = f6; m[1][3] = f7;
    m[2][0] = f8; m[2][1] = f9; m[2][2] = f10; m[2][3] = f11;
    m[3][0] = f12; m[3][1] = f13; m[3][2] = f14; m[3][3] = f15;
  }
  
  //trivial math functions
  Mat4 mult(float s){
    Mat4 ret = new Mat4();
    for(int r=0; r<4; r++)
      for(int c=0; c<4; c++)
        ret.set(r, c, m[r][c]*s);
    return ret;
  }
  Mat4 div(float s){
    Mat4 ret = new Mat4();
    for(int r=0; r<4; r++)
      for(int c=0; c<4; c++)
        ret.set(r, c, m[r][c]/s);
    return ret;
  }
  
  //non-trivial math functions
  Mat4 transpose(){
    Mat4 ret = new Mat4();
    for(int i = 0; i < 4; i++)
      for(int j = 0; j < 4; j++)
        ret.m[i][j] = this.m[j][i]; 
    return ret;
  }
  
  Mat4 mult(Mat4 m0){
    Mat4 ret = new Mat4();
    for (int i = 0; i < 4; i++)
    {
      ret.set(i, i, 0);
        for (int j = 0; j < 4; j++)
        {
            for (int k = 0; k < 4; k++)
            {
                ret.m[i][j] += (this.m[i][k] * m0.m[k][j]);
            }
        }
    }
    return ret;
  }
  
  Vec3 mult(Vec3 v){
    Vec3 ret = new Vec3();

    float temp = ((this.m[3][0] * v.x) + (this.m[3][1] * v.y) + (this.m[3][2] * v.z) + (this.m[3][3]));
    ret.x = ((this.m[0][0] * v.x) + (this.m[0][1] * v.y) + (this.m[0][2] * v.z) + (this.m[0][3])) / temp;
    ret.y = ((this.m[1][0] * v.x) + (this.m[1][1] * v.y) + (this.m[1][2] * v.z) + (this.m[1][3])) / temp;
    ret.z = ((this.m[2][0] * v.x) + (this.m[2][1] * v.y) + (this.m[2][2] * v.z) + (this.m[2][3])) / temp;
    return ret;
  }
  
  //other trivial utilities
  float get(int row, int col){ return m[row][col]; }
  void set(int row, int col, float val){ m[row][col] = val; }
  void setRotation(Mat3 rot){
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        m[r][c] = rot.get(r,c);
  }
  Mat3 getRotation(){
    Mat3 ret = new Mat3();
    for(int r=0; r<3; r++)
      for(int c=0; c<3; c++)
        ret.set(r, c, m[r][c]);
    return ret;
  }
  String toString(){    
    String s = "";
    for(int r=0; r<4; r++){
      s += "[";
      for(int c=0; c<4; c++){
        s+=m[r][c];
        if(c<3) s+= ",";
      }
      s += "]\n";
    }
    return s;
  }
  boolean equalTo(Mat4 m0){  
    for(int r=0; r<4; r++)
      for(int c=0; c<4; c++)
        if(m[r][c] != m0.get(r,c))
          return false;
    return true;
  }
  
  Mat4 translateMat(float tx, float ty, float tz) {
    Mat4 ret = new Mat4();
    ret.m[0][3] = tx;
    ret.m[1][3] = ty;
    ret.m[2][3] = tz;
    return ret;
  }
  
  Mat4 scaleMat(float sx, float sy, float sz){
    Mat4 ret = new Mat4();
    ret.m[0][0] = sx;
    ret.m[1][1] = sy;
    ret.m[2][2] = sz;
    return ret;
  }
  
  Mat4 rotateXMat(float theta) {
    Mat4 ret = new Mat4();
    ret.m[1][1] = cos((theta*PI)/180);
    ret.m[1][2] = -sin((theta*PI)/180);
    ret.m[2][1] = sin((theta*PI)/180);
    ret.m[2][2] = cos((theta*PI)/180);
    return ret;
  }
  
  Mat4 rotateYMat(float theta) {
    Mat4 ret = new Mat4();
    ret.m[0][0] = cos((theta*PI)/180);
    ret.m[2][0] = -sin((theta*PI)/180);
    ret.m[0][2] = sin((theta*PI)/180);
    ret.m[2][2] = cos((theta*PI)/180);
    return ret;
  }
  
  Mat4 rotateZMat(float theta) {
    Mat4 ret = new Mat4();
    ret.m[0][0] = cos((theta*PI)/180);
    ret.m[0][1] = -sin((theta*PI)/180);
    ret.m[1][0] = sin((theta*PI)/180);
    ret.m[1][1] = cos((theta*PI)/180);
    return ret;
  }
  
  Mat4 rotateMat(float theta, float x, float y, float z) {
   Mat4 ret = new Mat4();
   Vec3 A = new Vec3(x, y, z);
   Vec3 N;
   if(y == 0)
       N = new Vec3(0, 1, 0);
   else
      N = new Vec3(0, 0, 1); 
   A.normalize();
   Vec3 B = A.cross(N);
   B.normalize();
   Vec3 C = A.cross(B);
   C.normalize();
   Mat4 R1 = new Mat4(A.x, A.y, A.z, 0, B.x, B.y, B.z, 0, C.x, C.y, C.z, 0, 0, 0, 0, 1);
   Mat4 R2 = this.rotateXMat(theta);
   Mat4 R3 = R1.transpose();
   Mat4 RotationMatrix = R3.mult(R2);
   RotationMatrix = RotationMatrix.mult(R1);
   return RotationMatrix;
  }
}

