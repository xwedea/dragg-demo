using Godot;
using System;


public class LineDrawer
{

	public static MeshInstance3D Draw3DLines(Vector3 pos1, Vector3 pos2, Color color)
	{
		MeshInstance3D meshInstance = new MeshInstance3D();
		ImmediateMesh immediateMesh = new ImmediateMesh();
		OrmMaterial3D material = new OrmMaterial3D();

		meshInstance.Mesh = immediateMesh;
		meshInstance.CastShadow = GeometryInstance3D.ShadowCastingSetting.Off;

		immediateMesh.SurfaceBegin(Mesh.PrimitiveType.Lines, material);
		immediateMesh.SurfaceAddVertex(pos1);
		immediateMesh.SurfaceAddVertex(pos2);
		immediateMesh.SurfaceEnd();

		material.ShadingMode = BaseMaterial3D.ShadingModeEnum.Unshaded;
		material.AlbedoColor = color;

		return meshInstance;


	}

}


