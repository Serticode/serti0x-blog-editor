import { Schema, Types, model } from "mongoose";

const ArticleSchema = new Schema(
  {
    userId: {
      type: Types.ObjectId,
      ref: "User",
      required: [true, "Please provide a user id"],
    },
    title: {
      type: String,
      maxlength: [200, "Your title cannot exceed 200 characters"],
      trim: true,
      required: true,
    },
    category: {
      type: String,
      trim: true,
      required: true,
    },
    mediumURL: {
      type: String,
      trim: true,
      required: true,
    },
    content: {
      type: Array,
      default: [],
    },
    originalArticleId: {
      type: Types.ObjectId,
      ref: "Article",
      required: false,
    },
  },
  { timestamps: true }
);

ArticleSchema.methods.toJSON = function (): any {
  return {
    id: this._id,
    userId: this.userId,
    title: this.title,
    category: this.category,
    mediumURL: this.mediumURL,
    content: this.content,
    createdAt: this.createdAt,
  };
};

export interface ArticleDocument extends Document {
  userId: Types.ObjectId;
  title: string;
  category: string;
  mediumURL: string;
  content: [];
  originalArticleId?: Types.ObjectId;
  toJSON: () => any;
}

export default model<ArticleDocument>("Article", ArticleSchema);
