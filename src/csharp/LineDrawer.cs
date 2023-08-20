using Godot;
using Godot.Collections;
using System;

public class LineDrawer
{

	public static MeshInstance3D CreateLineMesh(Vector3 ballPos, Vector3 playerPos, float thickness, Color color)
	{
		MeshInstance3D meshInstance = new();
		meshInstance.CastShadow = GeometryInstance3D.ShadowCastingSetting.Off;

		ArrayMesh arrayMesh = new();
		meshInstance.Mesh = arrayMesh;
		
		Vector3 ballPos_right = ballPos + playerPos.DirectionTo(ballPos).Cross(Vector3.Up).Normalized() * thickness;
		Vector3 ballPos_left = ballPos + playerPos.DirectionTo(ballPos).Cross(Vector3.Down).Normalized() * thickness;
		Vector3 playerPos_left = playerPos + ballPos.DirectionTo(playerPos).Cross(Vector3.Up).Normalized() * thickness;
		Vector3 playerPos_right = playerPos + ballPos.DirectionTo(playerPos).Cross(Vector3.Down).Normalized() * thickness;

		Godot.Collections.Array meshData = new();
		meshData.Resize((int) ArrayMesh.ArrayType.Max);
		Vector3[] verts = new Vector3[] {
			ballPos_left, ballPos, playerPos_left, 
			playerPos_left, ballPos, playerPos,
			playerPos, ballPos, ballPos_right,
			ballPos_right, playerPos_right, playerPos
		};
		meshData[(int) Mesh.ArrayType.Vertex] = verts.AsSpan();
		arrayMesh.AddSurfaceFromArrays(Mesh.PrimitiveType.Triangles, meshData);

		return meshInstance;
	}



}